import { isEnvBrowser } from './misc'

/**
 * Simple wrapper around fetch API tailored for CEF/NUI use. This abstraction
 * can be extended to include AbortController if needed or if the response isn't
 * JSON. Tailor it to your needs.
 *
 * @param eventName - The endpoint eventname to target
 * @param data - Data you wish to send in the NUI Callback
 * @param mockData - Mock data to be returned if in the browser
 *
 * @return returnData - A promise for the data sent back by the NuiCallbacks CB argument
 */

interface WindowProps extends Window {
  GetParentResourceName: () => string;
}

export default async function <T = unknown>(eventName: string, data?: unknown, mockData?: T): Promise<T> {
  if (isEnvBrowser() && mockData) return mockData;

  const resourceName = (window as unknown as WindowProps).GetParentResourceName?.() ?? ''
  const response = await fetch(`https://${resourceName}/${eventName}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify(data),
  });

  return response.json();
}

